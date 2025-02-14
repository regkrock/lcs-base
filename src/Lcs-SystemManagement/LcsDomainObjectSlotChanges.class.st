Class {
	#name : #LcsDomainObjectSlotChanges,
	#superclass : #LcsSupportDomainObject,
	#traits : 'LtDomainCollection',
	#classTraits : 'LtDomainCollection classTrait',
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'instance creation' }
LcsDomainObjectSlotChanges class >> new [ 
	self traceCr: ' new ' , self name.
	^ super new
]
