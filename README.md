# OPERA_TROPO

Tropospheric Correction workflow for global OPERA TROPO products.

Creates the science application software (SAS) using the [RAiDER](https://github.com/dbekaert/RAiDER) library.

## Development setup


### Prerequisite installs
1. Download source code:
```bash
git clone https://github.com/dbekaert/RAiDER.git
git clone https://github.com/opera-adt/opera_tropo.git
```
2. Install dependencies, either to a new environment:
```bash
mamba env create --name my-tropo-env --file opera_tropo/conda-env.yml
conda activate my-disp-env
```
or install within your existing env with mamba.

3. Install `RAiDER` and `opera_tropo` via pip in editable mode
```bash
python -m pip install --no-deps -e RAiDER/ opera_tropo/
```

### Setup for contributing


We use [pre-commit](https://pre-commit.com/) to automatically run linting, formatting, and [mypy type checking](https://www.mypy-lang.org/).
Additionally, we follow [`numpydoc` conventions for docstrings](https://numpydoc.readthedocs.io/en/latest/format.html).
To install pre-commit locally, run:

```bash
pre-commit install
```
This adds a pre-commit hooks so that linting/formatting is done automatically. If code does not pass the checks, you will be prompted to fix it before committing.
Remember to re-add any files you want to commit which have been altered by `pre-commit`. You can do this by re-running `git add` on the files.

Since we use [black](https://black.readthedocs.io/en/stable/) for formatting and [flake8](https://flake8.pycqa.org/en/latest/) for linting, it can be helpful to install these plugins into your editor so that code gets formatted and linted as you save.

### Running the unit tests

After making functional changes and/or have added new tests, you should run pytest to check that everything is working as expected.

First, install the extra test dependencies:
```bash
python -m pip install --no-deps -e .[test]
```

Then run the tests:

```bash
pytest
```


### Building the docker image

To build the docker image, run:
```bash
./docker/build-docker-image.sh --tag my-tag
```
which will print out instructions for running the image.