import numc as nc 

m1 = nc.Matrix(3, 3, 0.1)
m2 = nc.Matrix(3, 3, 1.0)

print("m1 + m2 = ")
print(m1 + m2)
print("m1 - m2 = ")
print(m1 - m2)
print("m1 * m2 = ")
print(m1 * m2)
print("-m1 = ")
print(-m1)
print("abs(-m1) = ")
print(abs(-m1))
print("m1 ** 0 = ")
print(m1 ** 0)
print("m1 ** 2 = ")
print(m1 ** 2)

print("m1.get(1, 1): ", m1.get(1, 1))
print("set m1[1][1] = 2")
m1.set(1, 1, 2)
print("m1.get(1, 1): ", m1.get(1, 1))

