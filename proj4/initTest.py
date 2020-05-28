import numc as nc
# This creates a 3 * 3 matrix with entries all zeros
mat1 = nc.Matrix(3, 3)

# This creates a 2 * 3 matrix with entries all ones
mat2 = nc.Matrix(3, 3, 1)

# This creates a 2 * 3 matrix with first row 1, 2, 3, second row 4, 5, 6
mat3 = nc.Matrix([[1, 2, 3], [4, 5, 6]])

# This creates a 1 * 2 matrix with entries 4, 5
mat4 = nc.Matrix(1, 2, [4, 5])

# mat1
print(mat1[0]) # this gives the 0th row of mat1, should print out [[0.0], [0.0], [0.0]]
print(mat1[0][1]) # this should print out 0
mat1[0][1] = 5
print(mat1) # this should print out [[0.0, 5.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]]
mat1[0] = [4, 5, 6]
print(mat1) # this should print out [[4.0, 5.0, 6.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]]

# mat2
print(mat2) # [[1.0, 1.0, 1.0], [1.0, 1.0, 1.0], [1.0, 1.0, 1.0]]
mat2[1][1] = 2
print(mat2[1]) # [[1.0], [2.0], [1.0]]

# You can change a value in a slice, and that will change the original matrix
print(mat2) # [[1.0, 1.0, 1.0], [1.0, 2.0, 1.0], [1.0, 1.0, 1.0]]
mat2_slice = mat2[0] # [[1.0], [1.0], [1.0]]
mat2_slice[0] = 5
print(mat2_slice) # [[5.0], [1.0], [1.0]]
print(mat2) # [[5.0, 1.0, 1.0], [1.0, 2.0, 1.0], [1.0, 1.0, 1.0]]

