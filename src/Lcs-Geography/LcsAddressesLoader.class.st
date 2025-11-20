Class {
	#name : 'LcsAddressesLoader',
	#superclass : 'LcsObjectsLoader',
	#category : 'Lcs-Geography-Domain',
	#package : 'Lcs-Geography',
	#tag : 'Domain'
}

{ #category : 'data' }
LcsAddressesLoader >> data [
	^ ''
]

{ #category : 'configuration' }
LcsAddressesLoader >> targetClass [
	^ LcsAddress
]
