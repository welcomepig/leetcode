int myRead4(char *buf);

int myRead(char *buf, int n){
    if (n <= 0) return 0;
    
    int total = 0;
    int i, count, times = (n % 4 != 0) ? n / 4 + 1 : n / 4;
    
    for (i = 0;i < times; i++) {
        count = myRead4(buf + total);
        if (count == 0) break; 
        total += count;
    }
    
    return MIN(n, total);
}
