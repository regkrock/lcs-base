Class {
	#name : #LcsMABlockAccessor,
	#superclass : #MASelectorAccessor,
	#category : #'LcsBase-Accessor'
}

{ #category : #model }
LcsMABlockAccessor >> read: aModel [
	| block |
	block := aModel perform: self readSelector.
	^ LcsBlockSourceConverter innerSourceCodeOfSlotBlock: block
]

{ #category : #model }
LcsMABlockAccessor >> write: aString to: aModel [
	| block |
	block := LcsBlockSourceConverter slotBlockWithInnerSourceCode: aString replacing: (super read: aModel).
	super write: block to: aModel
]
