package `(sh/go-package-name buffer-file-name)`

import (
	"fmt"
	"testing"
)

biba-header$0

func Test`(sh/go-test-name buffer-file-name)`(t *testing.T) {
	tests := []struct {
		a,b,c int
	}{
		{1, 0, 1},
		{1, 1, 2},
	}

	for i, x := range tests {
		tt := x
		t.Run(fmt.Sprintf("test%v", i), func(t *testing.T) {
			c := tt.a + tt.b
			if c != tt.c {
				t.Errorf("something is seriously wrong, %v+%v != %v, got %v instead", tt.a,tt.b, tt.c,c)
			}
		})
	}
}
