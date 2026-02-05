# Given a list of integers, preserving order of other elements, move all -1 to the end in O(n) time and O(1) space
def cleanUpArjun(a):
    n = len(a)
    count = 0
    for i in range(n):
        if a[i] == -1:
            count += 1
        else:
            a[i - count] = a[i]
    for i in range(n-count, n):
        a[i] = -1
    return a

def cleanUpVardhan(a):
    j = 0
    n = len(a)
    for i in range(n):
        if a[i] != -1:
            a[j] = a[i]
            j += 1
    for k in range(j, n):
        a[k] = -1
    return a
