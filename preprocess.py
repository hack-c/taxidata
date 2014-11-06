import numpy as np
import pandas as pd


# parse commandline arguments
op = OptionParser()
op.add_option("--csv",
              dest="csv_path", type="str",
              help="Path to the csv for the relevant query.")

print(__doc__)
op.print_help()

(opts, args) = op.parse_args()
if len(args) > 0:
    op.error("this script takes no arguments.")
    sys.exit(1)
elif opts.csv_path is None:
    op.error("please specify the path to a csv.")
    sys.exit(1)



if __name__ == '__main__':

    fname = opts.csv_path.split('/')[-1][:-4]

    df = pd.read_csv(opts.csv_path)
    df = df[df.trips > 5]
    df = df[~df.distance.isnull()]
    df = df[['lat','lon','distance']]
    df.to_csv('data/processed/' + fname + '_processed.csv')
