# Blind Auction (Commit-Reveal) Smart Contract

A secure **Ethereum blind auction** implementation using a **commit-reveal scheme** to prevent **front-running** and **bid-sniping**.
Bidders first submit hashed commitments, then reveal actual bids later. The contract verifies integrity and selects the highest valid bidder.

---

## Objective

Prevent bidders from seeing each other's values before the auction ends by hiding bids using cryptographic hashing.

---

## How It Works

### Phase 1 — Commit Phase

Users submit a hash of their bid:

```
keccak256(bidValue, secretSalt)
```

Example:

```
Bid = 100
Secret = "abc"
Hash = keccak256(100, "abc")
```

Only the hash is stored on-chain.
Actual bid value remains hidden.

---

### Phase 2 — Reveal Phase

Users reveal:

* bidValue
* secretSalt

The contract verifies:

```
keccak256(revealedBid, revealedSecret) == storedHash
```

If mismatch → bidder is disqualified.

---

### Winner Selection

After reveal phase:

* Highest valid bid wins
* Invalid reveals ignored
* Winner address stored in `auctionWinner`

---

## Smart Contract Features

* Commit-Reveal auction model
* keccak256 hash verification
* Bid hiding during commit phase
* Invalid reveal disqualification
* Highest bid tracking
* Winner selection after reveal phase
* Multiple bidder support

---

## Project Structure

```
blind-auction/
│
├── BlindAuction.sol
├── Hash.sol
├── README.md
└── screenshots/
```

---

## Technology Used

* Ethereum
* Solidity
* Remix IDE
* keccak256 hashing
* JavaScript VM (local blockchain)

---

## Smart Contract Functions

### commitBid(bytes32 hash)

Stores hashed bid during commit phase.

```
commitBid(0xHASH)
```

---

### startReveal()

Ends commit phase and starts reveal phase.

```
startReveal()
```

---

### revealBid(uint value, string secret)

Reveals actual bid and verifies hash.

```
revealBid(100, "abc")
```

---

### getWinner()

Returns highest bidder address.

```
getWinner()
```

---

### highestBid()

Returns highest revealed bid.

---

## How to Run (Remix IDE)

### Step 1 — Deploy Hash Contract

Generate commitment hashes:

```
getHash(100, "abc")
getHash(200, "xyz")
```

---

### Step 2 — Deploy BlindAuction

Deploy contract using Remix VM.

---

### Step 3 — Commit Bids

Switch accounts and submit hashes:

```
Account 1 → commitBid(hash1)
Account 2 → commitBid(hash2)
```

---

### Step 4 — Start Reveal Phase

```
startReveal()
```

---

### Step 5 — Reveal Bids

```
Account 1 → revealBid(100, "abc")
Account 2 → revealBid(200, "xyz")
```

---

### Step 6 — Get Winner

```
getWinner()
```

Output:

```
Highest Bidder Address
```

---

## Example Execution

| Bidder | Bid | Secret | Valid |
| ------ | --- | ------ | ----- |
| User 1 | 100 | abc    | ✓     |
| User 2 | 200 | xyz    | ✓     |

Winner → **User 2**

---

## Expected Output

* Highest bid correctly selected
* Invalid reveals ignored
* Winner only after the reveal phase

---

## Security Benefits

Prevents:

* Front-running
* Bid sniping
* Bid manipulation
* Early bid exposure

---

## Screenshots

Deployment, hashing, commit phase, reveal phase, and winner output are included in `/screenshots`.

---

## Author

Name: Aarush Kashyap  
Course: Applications of Blockchain Technology  
Assignment: Blind Auction (Commit-Reveal)
