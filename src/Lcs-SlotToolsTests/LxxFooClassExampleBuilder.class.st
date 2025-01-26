Class {
	#name : #LxxFooClassExampleBuilder,
	#superclass : #LcsDomainClassBuilder,
	#category : #'Lcs-SlotToolsTests-Example'
}

{ #category : #initialize }
LxxFooClassExampleBuilder >> initialize [
	super initialize.
	self newClassName: 'Foo'.
	self targetPackageName: 'Lcs-Temp'
]
