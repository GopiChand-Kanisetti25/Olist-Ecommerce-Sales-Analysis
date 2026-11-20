import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

# Project data folder
data_path = Path(__file__).parent.parent / "Data" / "Raw"

# Load datasets
orders = pd.read_csv(data_path / "olist_orders_dataset.csv")
order_items = pd.read_csv(data_path / "olist_order_items_dataset.csv")
products = pd.read_csv(data_path / "olist_products_dataset.csv")

# Total orders
print("Total Orders:", orders["order_id"].nunique())

# Total product revenue
revenue = order_items["price"].sum()
print("Total Revenue: R$", round(revenue, 2))

# Top 10 product categories
sales = order_items.merge(products, on="product_id", how="left")

category_revenue = (
    sales.groupby("product_category_name")["price"]
    .sum()
    .sort_values(ascending=False)
    .head(10)
)

print("\nTop 10 Product Categories:")
print(category_revenue)