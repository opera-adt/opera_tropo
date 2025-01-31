import click

from .download import download
from .make_browse import make_browse
from .run import run_cli
#from .validate import validate


@click.group(name="opera_tropo")
@click.version_option()
@click.option("--debug", is_flag=True, help="Add debug messages to the log.")
@click.pass_context
def cli_app(ctx: click.Context, debug: bool) -> None:
    """Run a troposphere correction workflow."""
    # https://click.palletsprojects.com/en/8.1.x/commands/#nested-handling-and-contexts
    ctx.ensure_object(dict)
    ctx.obj["debug"] = debug


cli_app.add_command(run_cli)
#cli_app.add_command(validate)
cli_app.add_command(make_browse)
cli_app.add_command(download)

if __name__ == "__main__":
    cli_app()