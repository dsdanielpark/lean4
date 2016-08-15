/*
Copyright (c) 2014 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.

Author: Leonardo de Moura
*/
#include "library/equations_compiler/equations.h"
#include "library/equations_compiler/structural_rec.h"
#include "library/equations_compiler/compiler.h"

namespace lean{
void initialize_equations_compiler_module() {
    initialize_equations();
    initialize_structural_rec();
    initialize_compiler();
}

void finalize_equations_compiler_module() {
    finalize_compiler();
    finalize_structural_rec();
    finalize_equations();
}
}
