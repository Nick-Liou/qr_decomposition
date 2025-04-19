# QR Decomposition in MATLAB

This project contains a MATLAB implementation of the QR decomposition algorithm using **Givens rotations** and **Householder method**.
It includes a comparison with eachother and MATLAB’s built-in `qr()` function.

## Features

- Custom implementation of Givens QR (`GQR`)
- Custom implementation of Householder QR (`HQR`)
- Generation and testing on random matrices:
  - real-valued matrices [0, 1]
  - integer-valued matrices from [1, 100]
  - integer-valued matrices from [1, 1000]
- Benchmarking:
  - Execution time vs. matrix size
  - Precision using Frobenius norm (`‖Q*R - A‖_F`)
- Efficient matrix multiplication techniques for both methods:
  - Householder: optimized to O(n²)
  - Givens: optimized to O(n)
