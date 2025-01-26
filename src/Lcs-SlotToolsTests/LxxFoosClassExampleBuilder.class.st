Class {
	#name : #LxxFoosClassExampleBuilder,
	#superclass : #LcsDomainCollectionClassBuilder,
	#category : #'Lcs-SlotToolsTests-Example'
}

{ #category : #initialize }
LxxFoosClassExampleBuilder >> initialize [
	super initialize.
	self newClassName: 'Foo'.
	self targetPackageName: 'Lcs-Temp'
]
