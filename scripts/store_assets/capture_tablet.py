"""Capture translated tablet views from an already restored synthetic fixture."""
import argparse
from pathlib import Path
from capture_international import Capture


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('serial')
    parser.add_argument('size', type=int, choices=[7,10])
    parser.add_argument('output', type=Path)
    parser.add_argument('--locale', default='de-DE')
    args = parser.parse_args()
    capture = Capture(args.serial,args.locale,args.output)
    capture.home()
    if not capture.d.visible(capture.copy['projects'][0][0]):
        raise ValueError('Restore the localized synthetic fixture first')
    capture.tablets(only=args.size)


if __name__ == '__main__':
    main()
