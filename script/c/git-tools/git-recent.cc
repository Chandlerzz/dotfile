// SPDX-License-Identifier: GPL-2.0+ */
/*
 * git-recent - Show branches in order of their last modification
 *
 * Copyright (C) 2021 SUSE
 *
 * Author: Joerg Roedel <jroedel@suse.de>
 *
 * TODO:
 *		- Man page
 */
#include <algorithm>
#include <iostream>
#include <iomanip>
#include <string>
#include <vector>

#include <getopt.h>
#include <git2.h>

#include "version.h"

#define CLEARLINE	"\033[1K\r"

struct branch {
	std::string name;
	bool current;
	time_t last;
	std::string describe;
	const git_oid *oid;

	branch(std::string n, bool c, time_t l, const git_oid *o)
		: name(n), current(c), last(l), describe(), oid(o)
	{
	}

	bool operator<(const struct branch &b) const
	{
		return last > b.last;
	}
};

enum {
	OPTION_HELP,
	OPTION_VERSION,
	OPTION_ALL,
	OPTION_REPO,
	OPTION_REMOTE,
	OPTION_DESCRIBE,
	OPTION_LONG,
	OPTION_SHORT,
};

static struct option options[] = {
	{ "help",		no_argument,		0, OPTION_HELP           },
	{ "version",		no_argument,		0, OPTION_VERSION        },
	{ "all",		no_argument,		0, OPTION_ALL            },
	{ "repo",		required_argument,	0, OPTION_REPO		 },
	{ "remote",		required_argument,	0, OPTION_REMOTE         },
	{ "describe",		no_argument,		0, OPTION_DESCRIBE       },
	{ "long",		no_argument,		0, OPTION_LONG		 },
	{ "short",		no_argument,		0, OPTION_SHORT          },
	{ 0,			0,			0, 0                     }
};

static void usage(const char *cmd)
{
	std::cout << "Usage: " << cmd << " [options]" << std::endl;
	std::cout << "Options:" << std::endl;
	std::cout << "  --help, -h             Print this help message" << std::endl;
	std::cout << "  --version              Print version and exit" << std::endl;
	std::cout << "  --all, -a              Also show remote branches" << std::endl;
	std::cout << "  --repo <path>          Path to git repository" << std::endl;
	std::cout << "  --remote, -r <remote>  Only show branches of a given remote" << std::endl;
	std::cout << "  --describe, -d         Describe the top-commits of the branches" << std::endl;
	std::cout << "  --long, -l             Use long format for describe" << std::endl;
	std::cout << "  --short, -s            Print sorted branch names only" << std::endl;
}

bool is_prefix(std::string str, std::string prefix)
{
	if (str.size() < prefix.size())
		return false;

	return (str.substr(0, prefix.size()) == prefix);
}

int main(int argc, char **argv)
{
	git_branch_t flags = GIT_BRANCH_LOCAL;
	std::string::size_type max_len = 0;
	std::vector<branch> results;
	git_repository *repo = NULL;
	std::string repo_path = ".";
	bool describe_long = false;
	bool print_short = false;
	git_branch_iterator *it;
	std::string desc_prefix;
	git_branch_t ref_type;
	bool describe = false;
	git_reference *ref;
	std::string prefix;
	int error;

	while (true) {
		int c, opt_idx;

		c = getopt_long(argc, argv, "har:dls", options, &opt_idx);
		if (c == -1)
			break;

		switch (c) {
		case OPTION_HELP:
		case 'h':
			usage(argv[0]);
			return 0;
			break;
		case OPTION_VERSION:
			std::cout << "git-recent version " << GITTTOOLSVERSION << std::endl;
			return 0;
			break;
		case OPTION_ALL:
		case 'a':
			flags = GIT_BRANCH_ALL;
			break;
		case OPTION_REPO:
			repo_path = optarg;
			break;
		case OPTION_REMOTE:
		case 'r':
			flags = GIT_BRANCH_REMOTE;
			prefix = std::string(optarg) + '/';
			break;
		case OPTION_DESCRIBE:
		case 'd':
			describe = true;
			break;
		case OPTION_LONG:
		case 'l':
			describe_long = true;
		case OPTION_SHORT:
		case 's':
			print_short = true;
			break;
		default:
			usage(argv[0]);
			return 1;
		}
	}
	git_libgit2_init();

	error = git_repository_open(&repo, repo_path.c_str());
	if (error < 0)
		goto err;

	error = git_branch_iterator_new(&it, repo, flags);
	if (error < 0)
		goto err;

	while (git_branch_next(&ref, &ref_type, it) == 0) {
		git_commit *commit;
		const git_oid *oid;
		std::string sname;
		const char *name;

		error = git_branch_name(&name, ref);
		if (error < 0)
			goto err;

		sname = name;
		max_len = std::max(max_len, sname.size());

		if (!is_prefix(sname, prefix))
			continue;

		oid = git_reference_target(ref);
		if (oid == NULL) {
			std::cerr << "Can't get commit for branch " << sname << std::endl;
			continue;
		}


		error = git_commit_lookup(&commit, repo, oid);
		if (error < 0)
			goto err;

		results.emplace_back(branch(name,
					    (git_branch_is_head(ref) == 1),
					    static_cast<time_t>(git_commit_time(commit)),
					    oid));

		git_commit_free(commit);
	}

	git_branch_iterator_free(it);

	std::sort(results.begin(), results.end());

	if (describe && !print_short) {
		auto total = results.size();
		decltype(total) current = 1;

		for (auto &b : results) {
			git_describe_options desc_opts = GIT_DESCRIBE_OPTIONS_INIT;
			git_describe_format_options fmt_opts;
			git_describe_result *desc;
			git_buf buf = { 0 };
			git_object *obj;

			std::cout << CLEARLINE << "Describing branch " << b.name;
			std::cout << " (" << current++ << '/' << total << ')'<< std::flush;

			error = git_object_lookup(&obj, repo, b.oid, GIT_OBJ_COMMIT);
			if (error < 0) {
				std::cout << CLEARLINE << std::flush;
				goto err;
			}

			error = git_describe_commit(&desc, obj, &desc_opts);
			if (error < 0)
				continue;

			fmt_opts.version                = GIT_DESCRIBE_OPTIONS_VERSION;
			if (describe_long) {
				fmt_opts.abbreviated_size       = 12;
				fmt_opts.always_use_long_format = 1;
				desc_prefix = "branch at ";
			} else {
				fmt_opts.abbreviated_size       = 0;
				fmt_opts.always_use_long_format = 0;
				desc_prefix = "based on ";
			}
			fmt_opts.dirty_suffix           = "";

			git_describe_format(&buf, desc, &fmt_opts);

			b.describe = buf.ptr;

			git_describe_result_free(desc);
			git_object_free(obj);
		}

		std::cout << CLEARLINE << std::flush;
	}

	for (auto &b : results) {
		std::string prefix = b.current ? "* " : "  ";
		struct tm *tm;
		char t[32];

		if (print_short) {
			std::cout << b.name << std::endl;
			continue;
		}

		tm = localtime(&b.last);
		strftime(t, 32, "%Y-%m-%d %H:%M:%S", tm);
		std::cout << prefix << std::left << std::setw(max_len + 2) << b.name << "(" << t << ")";
		if (b.describe.size() > 0)
			std::cout << " ["<< desc_prefix << b.describe << "]";
		std::cout << std::endl;
	}

	git_repository_free(repo);
	git_libgit2_shutdown();

	return 0;

err:
	if (error < 0) {
		const git_error *e = giterr_last();
		std::cerr << "Error: " << e->message << std::endl;
	}

	if (it)
		git_branch_iterator_free(it);

	if (repo)
		git_repository_free(repo);

	git_libgit2_shutdown();

	return 1;
}
