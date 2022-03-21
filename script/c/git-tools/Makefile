CXX          = g++
CXXFLAGS     = -O3 -std=c++11 -Wall
TARGETS      = git-recent git-ff
INSTALL_DIR ?= ~/bin/

all: $(TARGETS)
git-ff: git-ff.o
	$(CXX) -o $@ $+ -lgit2

git-recent: git-recent.o
	$(CXX) -o $@ $+ -lgit2

install: $(TARGETS)
	install -b -D -m 755 git-recent $(INSTALL_DIR)
	install -b -D -m 755 git-ff $(INSTALL_DIR)

clean:
	rm -f *.o $(TARGETS)
