local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local snippets = {
    s("gs", t("{ get; set; }"), { description = "Auto property with getter and setter" }),

    s("gp", t("{ get; private set; }"), { description = "Auto property with private setter" }),

    s("g", t("{ get; }")),

    s("pk", {
        t("[Key]"),
        t({ "", "[DatabaseGenerated(DatabaseGeneratedOption.Identity)]" }),
        t({ "", "public " }), i(1, "int"), t(" "), i(2, "Id"), t(" { get; private set; }"),
    }, { description = "Primary key with EF Core annotations" }),

    s("fk", {
        t("[ForeignKey("), i(1), t(")]"),
    }, { description = "Foreign key annotation" }),

    s("uq", {
        t("[Index(nameof("), i(1, "PropertyName"), t("), IsUnique = true)]"),
    }, { description = "Unique index annotation" }),

    s("dset", {
        t("public DbSet<"), i(1, "Type"), t("> "), i(2, "VarName"), t(" => Set<"), i(3, "Type"), t(">();"),
    }, { description = "DbSet property for DbContext" }),

    s("prag", {
        t("#pragma warning disable CS8618"),
        t({ "", "protected " }),
        i(1, "ClassName"),
        t("() { }"),
        t({ "", "#pragma warning restore CS8618" }),
    }, { description = "Protected constructor with nullable warning suppression" }),

    s("tt", {
        t("[Fact]"),
        t({ "", "public void " }),
        i(1, "MethodName"),
        t("_"),
        i(2, "Scenario"),
        t("()"),
        t({ "", "{" }),
        t({ "", "    // Arrange" }),
        t({ "", "    " }),
        i(3),
        t({ "", "", "    // Act" }),
        t({ "", "    " }),
        i(4),
        t({ "", "", "    // Assert" }),
        t({ "", "    " }),
        i(5),
        t({ "", "}" }),
    }, { description = "xUnit test method with Arrange-Act-Assert sections" }),

    s("prop", {
        t("public "), i(1, "int"), t(" "), i(2, "MyProperty"), t(" { get; set; }"),
    }, { description = "Complete property declaration" }),

    s("try", {
        t("try"),
        t({ "", "{" }),
        t({ "", "    " }),
        i(1),
        t({ "", "}" }),
        t({ "", "catch (" }),
        i(2, "Exception"),
        t(" "),
        i(3, "ex"),
        t({ ")" }),
        t({ "", "{" }),
        t({ "", "    " }),
        i(0),
        t({ "", "}" }),
    }, { description = "Try-catch block" }),
}

return snippets
