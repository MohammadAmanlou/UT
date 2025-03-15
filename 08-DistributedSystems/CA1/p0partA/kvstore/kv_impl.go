// Basic key value access functions to be used in server_impl

package kvstore

import (
	"bytes"
)

type impl struct {
	internal map[string][]([]byte)
}

// CreateWithBackdoor -- Used by tests to create a KVStore implementation while keeping a handle on inner storage
func CreateWithBackdoor() (KVStore, map[string][]([]byte)) {
	internal := make(map[string][]([]byte))
	return impl{internal}, internal
}

// Put inserts a new key value pair or updates the value for a
// given key in the store
func (im impl) Put(key string, value []byte) {
	im.internal[key] = append(im.internal[key], value)
}

// Get fetches the value associated with the key
func (im impl) Get(key string) []([]byte) {
	valueList := im.internal[key]
	return valueList
}

// Delete removes all values associated with the key
func (im impl) Delete(key string) {
	delete(im.internal, key)
}

// Update replaces the old value in the message list for a given key in the
// store with the given new value. If the old value is not found, the new value
// will be updated for the given key.
func (im impl) Update(key string, oldVal []byte, newVal []byte) {
	valueList, exist := im.internal[key]
	if !exist {
		im.internal[key] = append(im.internal[key], newVal)
		return
	}
	markedIndex := -1
	for curIndex, curVal := range valueList {
		if bytes.Equal(curVal, oldVal) {
			markedIndex = curIndex
			break
		}
	}
	if markedIndex != -1 {
		temp := append(valueList[:markedIndex], valueList[markedIndex+1:]...)
		im.internal[key] = append(temp, newVal)
	} else {
		im.internal[key] = append(im.internal[key], newVal)
	}
}
