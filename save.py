import os
from frictionless import *
from dotenv import load_dotenv

load_dotenv()

package = describe(source="output/transferencias.csv", type="package")
package.to_sql(os.getenv('DB_CONNECTION'), name = os.getenv('DB_TABLE_NAME'))
