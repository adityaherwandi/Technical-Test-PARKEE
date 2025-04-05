#!/bin/bash

# Direktori dan ekstensi yang dicari
direktori="/home/aditya"
ekstensi="txt"

# Cari file dan tampilkan hasilnya
find "$direktori" -type f -name "*.${ekstensi}"
