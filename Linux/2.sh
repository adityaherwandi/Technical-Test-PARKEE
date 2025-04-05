#!/bin/bash

# Input source dan destination direktori
read -p "source direktori: " source_direktori
read -p "destination direktori: " destination_direktori

# Compress direktori
tar -czvf $destination_direktori $source_direktori
