import kontur.pie as pie


def start():
    pie.helpers.current_ib().open_designer()


def dump():
    pie.dump_ext(
        ext_map={
            "m10n_reprieve": "src/m10n_reprieve",
            "m10n_reprieve_tests": "src/m10n_reprieve_tests",
        }
    )


def load():
    pie.load_ext(ext_list=["src/m10n_reprieve", "src/m10n_reprieve_tests"], update=False)


def build():
    ext = pie.src.ExtSrc("src/m10n_reprieve")
    ext.set_props({"Version": pie.os.environ.get("CI_COMMIT_TAG", "0.0.0")})
    with pie.ib.TempIB() as ib:
        ib.load_src(src_list=["src/m10n_reprieve_base", str(ext)])
        ib.dump_cfe(ext_name="m10n_reprieve", cfe="build/m10n_reprieve.cfe")


def test():
    with pie.ib.TempIB() as ib:
        # Подготовка
        ib.load_src(src_list=["src/m10n_reprieve_base", "src/m10n_reprieve", "src/m10n_reprieve_tests"])
        ib.run(args="prepare")
        # Запуск
        test = pie.testframework.TestFramework()
        test.test_pattern = "src/m10n_reprieve_tests/DataProcessors/МИтТест.xml"
        test.va_settings.mdo_lib = ["DataProcessor.МИтТест.Form.Форма"]
        test.run(ib=ib, timeout=600)
        test.dump(junit="build/junit.xml")
        test.print()
