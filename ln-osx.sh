#!/bin/sh
for d in */; do
  stow "$d"
done
