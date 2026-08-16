# SHA-1 Implementation (RFC 3174)

This project provides a C implementation of the Secure Hash Algorithm 1 (SHA-1) exactly as specified in RFC 3174, which reproduces the algorithm from FIPS PUB 180-1. The code is modular, demo-ready for Ubuntu environments, and includes a comprehensive test suite.

## Overview

SHA-1 produces a 160-bit message digest for any input message less than 2^64 bits in length. It is commonly used for cryptographic integrity verification, digital signatures, and other security applications. This implementation follows the standard algorithm steps:

- Message padding to a multiple of 512 bits
- Parsing padded message into 512-bit blocks
- Processing each block through 80 rounds of operations
- Producing a final 160-bit hash value

## Files

- `sha1.h` – Header file with function prototypes and context structure
- `sha1.c` – Core SHA-1 implementation
- `sha1test.c` – Test driver that validates the implementation against the test vectors from FIPS PUB 180-1
- `Makefile` – Build automation
- `README.md` – This documentation

## Compilation

On Ubuntu, ensure you have `gcc` and `make` installed:

```bash
sudo apt update
sudo apt install build-essential
```

To compile the test program:

```bash
make
```

This will produce the `sha1test` executable.

To clean up build artifacts:

```bash
make clean
```

## Usage

The SHA-1 API consists of three functions:

1. `SHA1Reset(SHA1Context *context)` – Initialize a SHA-1 context for a new hash computation.
2. `SHA1Input(SHA1Context *context, const uint8_t *message_array, unsigned int length)` – Feed data into the hash context. Can be called multiple times.
3. `SHA1Result(SHA1Context *context, uint8_t Message_Digest[SHA1HashSize])` – Finalize the hash and retrieve the 20-byte digest.

Example usage:

```c
#include "sha1.h"

SHA1Context sha;
uint8_t digest[20];

SHA1Reset(&sha);
SHA1Input(&sha, (const uint8_t *)"abc", 3);
SHA1Result(&sha, digest);

// digest now contains the SHA-1 hash of "abc"
```

## Testing

Run the test suite with:

```bash
make test
```

or simply:

```bash
./sha1test
```

The test program verifies the implementation against the four test cases from FIPS PUB 180-1:

1. `"abc"` → `A9993E36 4706816A BA3E2571 7850C26C 9CD0D89D`
2. `"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"` → `84983E44 1C3BD26E BAAE4AA1 F95129E5 E54670F1`
3. `"a"` repeated 1,000,000 times → `34AA973C D4C4DAA4 F61EEB2B DBAD2731 6534016F`
4. `"01234567012345670123456701234567"` repeated 10 times → `DEA356A2 CDDD90C7 A7ECEDC5 EBB56393 4F460452`

The test also checks error handling for invalid inputs.

## Algorithm Details

The implementation follows these steps as defined in RFC 3174:

### 1. Message Padding
- Append a single '1' bit (0x80 byte)
- Append '0' bits until length ≡ 448 (mod 512)
- Append the original message length as a 64-bit big-endian integer

### 2. Hash Initialization
Initialize five 32-bit words (H0-H4) with specific constants:
- H0 = 0x67452301
- H1 = 0xEFCDAB89
- H2 = 0x98BADCFE
- H3 = 0x10325476
- H4 = 0xC3D2E1F0

### 3. Processing Each 512-bit Block
For each block:
- Expand the 16-word block into 80 words using circular left shifts and XOR operations
- Initialize working variables A-E with current hash values
- Perform 80 rounds of operations using different functions (Ch, Parity, Maj) and constants
- Add results back to hash values

### 4. Output
The final 160-bit digest is the concatenation of H0, H1, H2, H3, H4.

## Security Considerations

 **Note**: SHA-1 is considered cryptographically broken and should not be used for new security applications. It is vulnerable to collision attacks. This implementation is provided for educational and compatibility purposes only.

## References

- RFC 3174: US Secure Hash Algorithm 1 (SHA-1)
- FIPS PUB 180-1: Secure Hash Standard (SHS)

## Author

This implementation is based on the C code provided in RFC 3174, authored by Donald E. Eastlake, 3rd and Paul E. Jones.

## License

The RFC 3174 code is in the public domain. This project is released under the same terms.
