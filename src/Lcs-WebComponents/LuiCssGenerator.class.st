Class {
	#name : 'LuiCssGenerator',
	#superclass : 'LcsObject',
	#instVars : [
		'stream'
	],
	#category : 'Lcs-WebComponents-Libraries',
	#package : 'Lcs-WebComponents',
	#tag : 'Libraries'
}

{ #category : 'instance creation' }
LuiCssGenerator class >> generateMainCssFile [
	^ self new
		generateMainCssFileIn: LcsFileLibrary
]

{ #category : 'instance creation' }
LuiCssGenerator class >> generateMainCssFileIn: aFileLibraryClass [
	^ self new
		generateMainCssFileIn: aFileLibraryClass
]

{ #category : 'building' }
LuiCssGenerator >> addCssDefinitionsFrom: aFileLibrary [
	aFileLibrary new cssDefinitionSelectors
		do: [ :each | self stream nextPutAll: (aFileLibrary new perform: each asSymbol) ]
		separatedBy: [ self stream
				cr;
				cr ]
]

{ #category : 'building' }
LuiCssGenerator >> generateMainCssFileIn: aFileLibaryClass [
	self stream: (WriteStream on: String new).
	self addCssDefinitionsFrom: aFileLibaryClass.
	self writeMainCssMethod: aFileLibaryClass.
	^ self stream contents
]

{ #category : 'accessing' }
LuiCssGenerator >> stream [
	^ stream
]

{ #category : 'accessing' }
LuiCssGenerator >> stream: anObject [
	stream := anObject
]

{ #category : 'building' }
LuiCssGenerator >> writeMainCssMethod: aFileLibaryClass [
	aFileLibaryClass 
		compile: ('mainCss
	^ <1p>' expandMacrosWith: self stream contents)
]
