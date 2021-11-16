class Test:
    def __init__(self):
        self.test1 = 1
        self.test2 = 2

    @property
    def test3(self):
        return 3

    def setupmethod(f: F) -> F:
        """Wraps a method so that it performs a check in debug mode if the
        first request was already handled.
        """

        def wrapper_func(self, *args: t.Any, **kwargs: t.Any) -> t.Any:
            if self._is_setup_finished():
                raise AssertionError(
                    "A setup function was called after the first request "
                    "was handled. This usually indicates a bug in the"
                    " application where a module was not imported and"
                    " decorators or other functionality was called too"
                    " late.\nTo fix this make sure to import all your view"
                    " modules, database models, and everything related at a"
                    " central place before the application starts serving"
                    " requests."
                )
            return f(self, *args, **kwargs)

        return t.cast(F, update_wrapper(wrapper_func, f))
    def _is_setup_finished(self) -> bool:
        raise NotImplementedError


