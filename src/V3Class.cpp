// -*- mode: C++; c-file-style: "cc-mode" -*-
//*************************************************************************
// DESCRIPTION: Verilator: Handle SV classes
//
// Code available from: https://verilator.org
//
//*************************************************************************
//
// Copyright 2003-2020 by Wilson Snyder.  This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.
//
// Verilator is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
//*************************************************************************
// V3Class's Transformations:
//
// Each class:
//      Move to just under AstNetlist
//
//*************************************************************************

#include "config_build.h"
#include "verilatedos.h"

#include "V3Global.h"
#include "V3Class.h"
#include "V3Ast.h"

//######################################################################

class ClassVisitor : public AstNVisitor {
private:
    // NODE STATE
    //  AstClass::user1()       -> bool.  True if iterated already
    AstUser1InUse m_inuser1;
    string m_prefix;  // String prefix to add to name based on hier

    // METHODS
    VL_DEBUG_FUNC;  // Declare debug()

    virtual void visit(AstClass* nodep) {
        if (nodep->user1SetOnce()) return;
        string prevPrefix = m_prefix;
        {
            m_prefix = nodep->name() + "__02e";  // .
            iterateChildren(nodep);
        }
        m_prefix = prevPrefix;
        // Handle this class
        nodep->name(m_prefix + nodep->name());
        nodep->unlinkFrBack();
        v3Global.rootp()->addMiscsp(nodep);
    }
    virtual void visit(AstPackage* nodep) {
        string prevPrefix = m_prefix;
        {
            m_prefix = nodep->name() + "__03a__03a";  // ::
            iterateChildren(nodep);
        }
        m_prefix = prevPrefix;
    }

    virtual void visit(AstNodeMath* nodep) {}  // Short circuit
    virtual void visit(AstNode* nodep) { iterateChildren(nodep); }

public:
    // CONSTRUCTORS
    explicit ClassVisitor(AstNetlist* nodep) { iterate(nodep); }
    virtual ~ClassVisitor() {}
};

//######################################################################
// Class class functions

void V3Class::classAll(AstNetlist* nodep) {
    UINFO(2, __FUNCTION__ << ": " << endl);
    { ClassVisitor visitor(nodep); }  // Destruct before checking
    V3Global::dumpCheckGlobalTree("class", 0, v3Global.opt.dumpTreeLevel(__FILE__) >= 3);
}
