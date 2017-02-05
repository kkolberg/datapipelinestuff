import argparse

def replaceToken(stub, output, object, depend):
    depStr = ""
    title = object
    name = object.lower()
    if depend is not None:
        depStr="""            - Key: dependsOn
              RefValue: Archive_""" + depend + "_File"
        
    with open(stub, 'r') as __in:
        with open(output, 'a+') as __out:
            __out.write("\n")
            for line in __in:
                fixed = line.replace('|Title|', title)
                fixed = fixed.replace('|Name|', name)
                fixed = fixed.replace('|Depend|', depStr)
                __out.write(fixed)


if __name__ == "__main__":
    PARSER = argparse.ArgumentParser(description="Stub builder")
    PARSER.add_argument(
        "--stub",
        help="Stub template")
    PARSER.add_argument(
        "--output",
        help="Output file")
    PARSER.add_argument(
        "--objects",
        help="Objects to stub")
    ARGS = PARSER.parse_args()
    
    objects =ARGS.objects.split(',')
    prev = None
    for object in objects:
        replaceToken(ARGS.stub, ARGS.output, object, prev)
        prev = object


