Class {
	#name : 'LcsSystemDomainClassesMethodBuilder',
	#superclass : 'LcsMethodBuilder',
	#category : 'Lcs-SlotTools',
	#package : 'Lcs-SlotTools'
}

{ #category : 'command' }
LcsSystemDomainClassesMethodBuilder >> methodSource [
^'systemDomainClasses
	| collection |
	collection := super systemDomainClasses.
	self addClasses: self class package definedClasses to: collection.
	^ collection'
]
