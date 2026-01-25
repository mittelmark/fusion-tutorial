# Tutorial and Code examples for the Fusion Programming Language

The [Fusion programming language](https://www.fusion-lang.org/) allows you to
write code which can be transpiled to code for other programming languages
like C, C++, Java and others. The generated C or C++ code can be then used in
scripting languages like Tcl, R or others using the
[Simplified Warapper and Interface Generator (Swig)](https://swig.org). 

Below you see a list of programming languages which you can target directly
using using the [fut - command line tool for Fusion](https://github.com/fusionlanguage/fut/)
or, indirectly, using the C or C++ generated code and swig.


![Diagram](https://kroki.io/graphviz/svg/eNp1UU1PGzEQvfMrRu6lCDcB1EqVkHtZaBFCgGhuUQ5ee5IdxbEX25uwVPx3vF5Dg0oty18z7_nNG00rL9sGzuHPAaSRb3Mje9dFEXeuJe6di6K6uJld3C9yTqAnFOz72Vd2lu_WaZyH2BsUSzIGNR825YzzIkizcZaHRrYoavfId6RjI04mxyMX6hVCAQdnSPMNWYNWnIxxL-06YCtOYTqFgDE9aOoCB7JpqgZDTvu9oxV8-QHV6VyTF7VU68W7wFhdGjNlOFx3ksN9ml3dc7hVUW6Rwx16843DL5eOl3cc2GQyYRn3_MaVrKnRCDacWSlLkVcG94pmYd3XpkO2SKgMTboKsGIfJo7F_nUahnoxRFkbCg3EBuEz2S0Fqg0egkIb0WfnM3I63TcyJ46UI1v5_GcX6K0Z_6guWhaFsEA_4CydwIeONCWJViFIY7KaAEvvNgW7p-BdD1h1dMSSv9WntJ5zuJJbyYclKE9tTPb3sUlCoeKD6cv0MutbfI3etmir61drx95ANf-frQfPL1Yj40o=)

## Example

Here the classical Hello World exanple:

```csharp
public class HelloFu
{
    public static string GetMessage()
    {
        return "Hello, world!";
    }
}
```

The folder [samples/hello] contains a Makefile which shows how to translate this code into these various programming languages as well as one example to 
