# Given a list of integers, preserving order of other elements, move all -1 to the end in O(n) time and O(1) space
def cleanUpArjun(a):
    # Was also suggested by Neel and Siddhant
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

def cleanupRushikesh(A:list) -> list:
    #Very similar to Shubh's code, although his was more verbose and 'formal' logic-y
    k = 0
    n = len(A)
    for i in range(n):
        if A[i] != -1:
            A[i], A[k] = A[k], A[i]
            k += 1
    return A



def maxArea(height):
    n = len(height)
    i = 0
    j = n-1
    arr = []
    while i != j:
        if height[i] < height[j]:
            arr += [height[i] * (j - i)]
            i += 1
        else:
            arr += [height[j] * (j-i)]
            j -= 1
    return max(arr)

print(maxArea([3,6,2,6,7,3]))