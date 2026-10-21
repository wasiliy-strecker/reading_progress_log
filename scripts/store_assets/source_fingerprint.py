"""Hash the reviewable app source, including uncommitted and new source files."""
import hashlib
from pathlib import Path
import subprocess


def fingerprint():
    paths = subprocess.check_output(['git', 'ls-files', '-z', '--cached', '--others', '--exclude-standard']).split(b'\0')
    digest = hashlib.sha256()
    for name in sorted(set(paths)):
        if not name:
            continue
        path = Path(name.decode())
        if path.is_file():
            digest.update(name + b'\0' + hashlib.sha256(path.read_bytes()).digest())
    return digest.hexdigest()


if __name__ == '__main__':
    print(fingerprint())
