import os
import sys

name = " ".join(sys.argv[1:]) or "Nobody"    # the name typed after the command, if any
bounty = os.environ.get("BOUNTY", "1,000")   # read from an environment variable
print(f"WANTED: {name} - bounty {bounty} berries")
