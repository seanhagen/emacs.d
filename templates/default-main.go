package `(file-name-nondirectory (directory-file-name (file-name-directory buffer-file-name)))`

import (
	"fmt"
	"testing"
)

func TestBasic(t *testing.T){
	tests := []struct{
		a,b,c int
	}{
		{1,1,2}
	}

	for i,x := range tests {
		tt := x
		t.Run(fmt.Sprintf("test%v",i), func(t *testing.T){
			c := tt.a + tt.c
			if c != tt.c {
				t.Errorf("invalid result, expected %v got %v", tt.c, c)
			}
		})
	}
}
