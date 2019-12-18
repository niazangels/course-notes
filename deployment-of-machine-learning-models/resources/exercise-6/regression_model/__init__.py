from pathlib import Path

PACKAGE_ROOT = Path(__file__).resolve().parent
TRAIN_MODEL_DIR = PACKAGE_ROOT / "trained_models"
DATASET_DIR = PACKAGE_ROOT / "datasets"

TRAIN_FILE = DATASET_DIR / "train.csv"
TEST_FILE = DATASET_DIR / "test.csv"
TARGET = "SalePrice"

FEATURES = [
    "MSSubClass",
    "MSZoning",
    "Neighborhood",
    "OverallQual",
    "OverallCond",
    "YearRemodAdd",
    "RoofStyle",
    "BsmtQual",
    "BsmtExposure",
    "HeatingQC",
    "CentralAir",
    "1stFlrSF",
    "GrLivArea",
    "BsmtFullBath",
    "KitchenQual",
    "Fireplaces",
    "FireplaceQu",
    "GarageType",
    "GarageFinish",
    "GarageCars",
    "PavedDrive",
    # This variable is only to calculate elapsed time
    "YrSold",
]


def save_pipeline() -> None:
    """
    Persist the pipeline
    """
    print("Saving the pipeline")
    pass


def run_training() -> None:
    """
    Train the model
    """
    print("Training")
    pass


if __name__ == "__main__":
    run_training()
