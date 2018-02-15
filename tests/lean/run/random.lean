import system.random
universes u

def tst1 : nat :=
let s       := mk_std_gen,        /- create standard random number generator -/
    (v, s') := rand_nat s 0 100   /- generate a random nat in [0, 100]. -/
in v

#eval tst1

def tst2 : bool × bool × bool × bool :=
let s        := mk_std_gen,    /- create standard random number generator -/
    (b₁, s₁) := rand_bool s,   /- generate a random Boolean -/
    (b₂, s₂) := rand_bool s₁,  /- generate another random Boolean -/
    (b₃, s₃) := rand_bool s₂,
    (b₄, _)  := rand_bool s₃
in (b₁, b₂, b₃, b₄)

#eval tst2

/- `rand_list sz g lo hi` generates a list of size `sz` with
   random nat's in [lo, hi] generated by `g`. -/
def rand_list : nat → std_gen → nat → nat → list nat × std_gen
| 0     g lo hi := ([], g)
| (n+1) g lo hi :=
  let (l, g₁) := rand_list n g lo hi,
      (v, g₂) := rand_nat g₁ lo hi
  in (v::l, g₂)

#eval (rand_list 20 mk_std_gen 0 10).1

/- Version of rand_list that is parametrized by any random number generator implementation -/
def gen_rand_list {gen : Type u} [random_gen gen] : nat → gen → nat → nat → list nat × gen
| 0     g lo hi := ([], g)
| (n+1) g lo hi :=
  let (l, g₁) := gen_rand_list n g lo hi,
      (v, g₂) := rand_nat g₁ lo hi
  in (v::l, g₂)

#eval (gen_rand_list 20 mk_std_gen 0 10).1

/- We can implement our own number generators.
   Here is a 'dumb' one that just generates a sequence -/

structure dummy_gen :=
(lo hi : nat)
(next : nat := lo)

instance : random_gen dummy_gen :=
{ range := λ s, (s.lo, s.hi),
  next  := λ s, (s.next, {next := s.next + 1, ..s}),
  split := λ s, (s, s) }

def mk_dummy_gen (lo : nat := 0) (hi : nat := 100000) : dummy_gen :=
{lo := lo, hi := hi}

/- Invoke gen_rand_list using the dummy generator. -/
#eval (gen_rand_list 20 mk_dummy_gen 0 10).1
