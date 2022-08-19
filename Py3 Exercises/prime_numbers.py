primelist = []

for i in range (2,101):
    result = []
    
    for n in range (2,i):
        div = i % n
        result.append(div)
    # print(result)
    
    if 0 in result:
        # print ("{} is not a prime".format(i))
        continue
    elif 0 not in result:
        # print("{} is a prime".format(i))
        primelist.append(i)

print("Primes numbers are:",primelist)
