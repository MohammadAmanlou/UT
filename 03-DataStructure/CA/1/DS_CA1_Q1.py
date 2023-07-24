tabel_size = input()
columns_name = input()
tabel_size = tabel_size.split()
columns_name = columns_name.split(",")
data = []
for i in range(0 , int(tabel_size[0])):
    line = input()
    line = line.split(",")
    data.append(line)
sort_by = input()
sort_by = sort_by.split()
sort_by = sort_by[-1]
column_number = columns_name.index(sort_by)
data.sort(key=lambda x: x[column_number])
for d in data :
    print (",".join(d))