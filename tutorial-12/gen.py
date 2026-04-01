import csv
import os

# ===== CONFIG =====
csv_file = "p4.csv"   # your CSV file
output_dir = "p4"         # folder to store .in/.out files
prefix = "des"        # file prefix
# ==================

os.makedirs(output_dir, exist_ok=True)

with open(csv_file, newline='') as f:
    reader = csv.DictReader(f)
    
    for i, row in enumerate(reader, start=1):
        inp = row["input"].strip()
        out = row["output"].strip()
        
        in_filename = os.path.join(output_dir, f"{prefix}{i}.in")
        out_filename = os.path.join(output_dir, f"{prefix}{i}.ans")
        
        # Write input file
        with open(in_filename, "w") as fin:
            fin.write(inp + "\n")
        
        # Write output file
        with open(out_filename, "w") as fout:
            fout.write(out + "\n")

print(f"Generated {i} test cases in '{output_dir}' folder.")