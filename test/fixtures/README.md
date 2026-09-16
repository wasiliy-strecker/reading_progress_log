# Synthetic backup fixture

`legacy_single_photo_v3.shbackup` was generated with the version-3 codec from
commit `a255e1f`. It contains one synthetic project, one reading, and the four
bytes `1, 2, 3, 4` as a test photo. There are no user data or real photographs.
The public test password is `fixture-only` and is not a secret.

This immutable fixture verifies decryption and restoration of archives produced
before multiple photos and backup version 4 were introduced.
