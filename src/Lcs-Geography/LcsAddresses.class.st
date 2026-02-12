Class {
	#name : 'LcsAddresses',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'defaults' }
LcsAddresses >> defaultInstance [
	^ self error: 'This needs to be implmeneted' "LcsAddress new"
]

{ #category : 'defaults' }
LcsAddresses >> unknownInstance [
	^ self currentSystem geographyModule addresses unknownInstance
]
