# name = Aaron, date = 10/8/22

units = input("How many fizzing and buzzing units do you need in your life?")
units = int(units)
count = 0
fbcount=0

while fbcount < units:
    
    if count%3 == 0 and count%5 == 0:
        print("fizz buzz")
        fbcount += 1
    elif count%3 == 0:
        print("fizz")
        fbcount += 1
    elif count%5 ==0:
        print("buzz")
        fbcount += 1
    else:
        print(count)
    
    count += 1
print ("TRADITION!!")

## 0 is a multiple of every number
