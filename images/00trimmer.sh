#!/usr/bin/bash
ls -1 *png | sed "s|\(.*\)|magick convert \"\1\" -trim \"\1\"|"|sh

ls -1 *png | sed "s|\(.*\)|magick convert -bordercolor black -border 1 \"\1\" \"\1\"|" | sh
