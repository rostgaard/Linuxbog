#!/usr/bin/runhugs

-- hello.hs - Hello world for Haskell using Hugs
-- af Peter Makholm <peter@makholm.net
-- $Id$
--
-- Afvikling:
--  1. chmod +x hello.hs
--  2. ./hello.hs
-- eller
--  1. runhugs hello.hs

module Main where
  main = putStr "Hello, world!\n"
