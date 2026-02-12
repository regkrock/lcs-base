Class {
	#name : 'LcsSystemDomainClassesMethodBuilder',
	#superclass : 'LcsMethodBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'command' }
LcsSystemDomainClassesMethodBuilder >> methodSource [
^'systemDomainClasses
	| collection |
	collection := super systemDomainClasses.
	self addClasses: self class package definedClasses to: collection.
	^ collection'
]
