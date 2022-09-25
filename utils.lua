local function read_ui16(byte1, byte2)
    assert (0 <= byte1 and byte1 <= 0xff)
    assert (0 <= byte2 and byte2 <= 0xff)
    local res  = bit.bor(
        bit.lshift(byte1, 8),
        bit.lshift(byte2, 0)
    )
    return res
end

return {
    read_ui16 = read_ui16
}
