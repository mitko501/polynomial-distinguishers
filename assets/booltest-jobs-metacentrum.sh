#!/bin/bash

export HOMEDIR="/storage/brno3-cerit/home/${LOGNAME}"
export BOOLTEST="${HOMEDIR}/booltest"
export EACIRC_ESTREAM="${HOMEDIR}/eacirc-streams/build/eacirc-streams"
cd $HOMEDIR

export MPICH_NEMESIS_NETMOD=tcp
export OMP_NUM_THREADS=$PBS_NUM_PPN
export PYENV_ROOT="${HOMEDIR}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
echo "`hostname` starting..."

module add gcc-5.3.0
module add cmake-3.6.1
module add mpc-1.0.3
module add gmp-6.1.2
module add mpfr-3.1.4

eval "$(pyenv init -)"
#sleep 3

pyenv local 3.6.4
#sleep 3


export HDIR=/storage/brno3-cerit/home/ph4r05/
export RESDIR=$HDIR/bool-res
export BACKDIR=$HDIR/bool-back
export JOBDIR=$HDIR/bool-jobNr14
export SIGDIR=$HDIR/bool-sig

export JOBDIR=$HDIR/bool-jobNr29
export JOBDIR=$HDIR/bool-jobNr30
mkdir -p $JOBDIR
mkdir -p $BACKDIR
mkdir -p $SIGDIR

cd $JOBDIR

exec stdbuf -eL python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
 --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
 --top 128 --matrix-size 1 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 \
 --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
 --topterm-heap-k 256 --skip-finished --narrow


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --narrow --no-reinit --no-sac --no-xor-strategy


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --narrow --no-reinit --no-sac --no-xor-strategy --counters-only

python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --skip-existing --narrow --no-xor-strategy \
    --inhwr4 --inhwr2 --only-crypto blowfish --only-rounds 1 2 3

python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 128 256 384 512 \
    --topterm-heap-k 256 --skip-finished --skip-existing --narrow --no-xor-strategy  \
    --rescan-jobs --overwrite-existing


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --ignore-existing --narrow --no-xor-strategy \
    --inhwr4 --inhwr2 --only-crypto blowfish --only-rounds 8 9 10 11 \
    --only-strategy in0-khw1rs-ri1 in0-khw2rs-ri1 in0-khw4rs-ri1 in0-khw1i-ri1 in0-khw1si-ri1


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --ignore-existing --narrow2 --no-xor-strategy \
    --only-crypto md5 --only-rounds 13 14 15 16 17 18 \
    --only-strategy in0-khw4r-ri0 in0-khw4rs-ri0 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --no-reinit --skip-finished --ignore-existing --narrow2 --no-xor-strategy \
    --only-crypto keccak --only-rounds 1 2 3 \
    --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --no-counters --skip-finished --ignore-existing --narrow2  \
    --only-crypto tea --only-rounds 1 2 3 4 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --no-counters --expiring --ignore-existing --skip-finished --narrow2  \
    --only-crypto sha256 --only-rounds 1 2 3 4 5 6 7 8 9 10 11 12 13 14 --enqueue

python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --no-counters --skip-finished --ignore-existing --narrow2  \
    --only-crypto md6 --only-rounds 1 2 3 4 5 6 7 --enqueue

python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --no-counters --skip-finished --ignore-existing --narrow2  \
    --only-crypto md5 --only-rounds 1 2 3 4 5 6 7 9 10 11 12 13 14 15 16 --enqueue

python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --no-counters --skip-finished --ignore-existing --narrow2  \
    --only-crypto jh --only-rounds 1 2 3 4 5 6 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --ignore-existing --narrow2  \
    --only-crypto grostl --only-rounds 1 2 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --ignore-existing --narrow2  \
    --only-crypto aes --only-rounds 1 2 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --ignore-existing --narrow2 --no-xor-strategy \
    --inhwr4 --inhwr2 --only-crypto single-des --only-rounds 3 4 5 6 7 8 9 10 \
    --only-strategy in0-khw1rs-ri1 in0-khw2rs-ri1 in0-khw4rs-ri1 in0-khw1i-ri1 in0-khw1si-ri1 in0-khw6r-ri1


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --skip-finished --ignore-existing --narrow2 --no-xor-strategy \
    --inhwr4 --inhwr2 --only-crypto blowfish --only-rounds 3 4 5 6 7 8 9 10 11 12 13 14 \
    --only-strategy in0-khw1rs-ri1 in0-khw2rs-ri1 in0-khw4rs-ri1 in0-khw1i-ri1 in0-khw1si-ri1 in0-khw6r-ri1


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --ignore-existing --narrow2  \
    --only-crypto single-des triple-des --only-rounds 1 2 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --ignore-existing --narrow2  \
    --only-crypto tea --only-rounds 1 2 3 4 --enqueue


#-----rnd2-----rnd2-----rnd2-----rnd2-----rnd2-----rnd2-----rnd2-----rnd2-----rnd2-----rnd2-----rnd2

python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto aes --only-rounds 1 2 3 4 --rand-runs 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto blowfish --only-rounds 1 2 3 4 --rand-runs 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto single-des --only-rounds 1 2 3 4 --rand-runs 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto triple-des --only-rounds 1 2 3 4 --rand-runs 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto grostl --only-rounds 1 2 3 --rand-runs 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto jh --only-rounds 1 2 3 5 6 7 --rand-runs 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto keccak --only-rounds 1 2 3 --rand-runs 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto md5 --only-rounds 3 4 5 6 7 8 9 10 11 12 13 --rand-runs 3 --enqueue



python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto md6 --only-rounds 5 6 7 8 9 --rand-runs 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto sha256 --only-rounds 3 4 5 6 7 11 12 13 14 --rand-runs 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto tea --only-rounds 1 2 3 4 --rand-runs 3 --enqueue

python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --skip-existing --narrow2  \
    --only-crypto sha1 --only-rounds 4 5 6 7 8 9 10 11 12 13 14 --rand-runs 3 --enqueue


#-----rnd3-----rnd3-----rnd3-----rnd2-----rnd2-----rnd2-----rnd2-----rnd3-----rnd3-----rnd3-----rnd3




python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --no-counters --no-rpcs --overwrite-existing --narrow2  \
    --only-crypto md5 --only-rounds 13 14 --rand-runs 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --no-counters --no-sac --overwrite-existing --narrow2  \
    --only-crypto md5 --only-rounds 5 6 --rand-runs 3 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --no-counters --no-rpcs --overwrite-existing --narrow2  \
    --only-crypto blowfish --only-rounds 1 2 3 --rand-runs 3 --enqueue



python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --no-sac --no-rpcs --overwrite-existing --narrow2  \
    --only-crypto sha1 --only-rounds 13 14 --enqueue


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --no-counters --skip-finished --no-rpcs --overwrite-existing --narrow2  \
    --only-crypto sha1 --only-rounds 11 12 13 14 15 16 --enqueue



python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 128 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --no-xor-strategy --no-reinit --skip-finished --narrow2 --help



python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 128 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --skip-finished --benchmark --cluster lex --only-strategy inctr-krnd-ri0 --test-rand-runs 5


python booltest/testjobs.py --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR --backup-dir=$BACKDIR \
    --top 128 --matrix-size 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 128 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap --topterm-heap-k 256 \
    --skip-finished --narrow2 --only-strategy inctr-krnd-ri0 inhw4-krnd-ri0 in0-khw1rs-ri1 in0-khw4rs-ri1 in0-kctr-ri1 --test-rand-runs 3




# ------------------------------------------------------------------


# Reference statistics for new test sizes
python ../booltest/booltest/testjobs.py  \
    --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 1 5 10 95 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 128 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --ref-only --skip-existing --counters-only --no-sac --no-rpcs --no-reinit

# Tests with fixed data files - card TRNG output
python ../booltest/booltest/testjobs.py  \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 1 10 95 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 128 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --no-functions --ignore-existing --test-files ../card_prng/*.bin


python ../booltest/booltest/testjobs.py  \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 1 10 95 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 128 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --no-functions --test-files ../card_prng/*.bin \
    --rescan-jobs --overwrite-existing

# Ref 16bit
python ../booltest/booltest/testjobs.py  \
    --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 1 5 10 95 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 16 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --ref-only --skip-existing --counters-only --no-sac --no-rpcs --no-reinit

# Test 16 bit
python ../booltest/booltest/testjobs.py  \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 1 10 95 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 16 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --no-functions --ignore-existing --test-files ../card_prng/Infi*.bin


# ------------------------------------------------------------------

python ../booltest/booltest/testjobs.py  \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 1 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --no-functions --ignore-existing \
    --generator-folder ../bool-cfggens/ --generator-path ../bool-cfggens/crypto-streams_v2.3-13-gff877be


python ../booltest/booltest/testjobs.py  \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 1 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --no-functions --ignore-existing \
    --generator-folder ../bool-cfggens-8gb/ --generator-path ../bool-cfggens/crypto-streams_v2.3-13-gff877be

python ../booltest/booltest/testjobs.py  \
    --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 10 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 128 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --ref-only --test-rand-runs 1000 --skip-existing --counters-only --no-sac --no-rpcs --no-reinit

python ../booltest/booltest/testjobs.py  \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 1 10 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --no-functions --ignore-existing \
    --generator-folder ../bool-cfggens/ --generator-path ../bool-cfggens/crypto-streams_v2.3-13-gff877be \
    --enqueue --qsub-ncpu 2


python ../booltest/booltest/testjobs.py  \
    --generator-path $HDIR/eacirc-streams/build/eacirc-streams \
    --data-dir $RESDIR --job-dir $JOBDIR --result-dir=$RESDIR \
    --top 128 --matrix-size 100 --matrix-comb-deg 1 2 3 --matrix-deg 1 2 3 --matrix-block 128 256 384 512 \
    --no-comb-and --only-top-comb --only-top-deg --no-term-map --topterm-heap \
    --topterm-heap-k 256 --skip-finished --ref-only --test-rand-runs 1000 --skip-existing --counters-only --no-sac --no-rpcs --no-reinit


