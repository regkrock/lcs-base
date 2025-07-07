Class {
	#name : #LcsMABlockAccessor,
	#superclass : #MASelectorAccessor,
	#category : #'LcsBase-Accessor'
}

{ #category : #model }
LcsMABlockAccessor >> basicRead: aModel [
	^ aModel slotModelBuilder perform: self readSelector
]

{ #category : #model }
LcsMABlockAccessor >> read: aModel [
	| block |
	block := self basicRead: aModel.
	^ LcsBlockSourceConverter innerSourceCodeOfSlotBlock: block
]

{ #category : #model }
LcsMABlockAccessor >> write: aString to: aModel [
	| block |
	block := LcsBlockSourceConverter slotBlockWithInnerSourceCode: aString replacing: (self basicRead: aModel ).
	super write: block to: aModel slotModelBuilder
]
