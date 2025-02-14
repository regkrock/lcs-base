Class {
	#name : #LcsDomainObjectChangeRecords,
	#superclass : #LcsSupportDomainObject,
	#traits : 'LtDomainCollection',
	#classTraits : 'LtDomainCollection classTrait',
	#category : #'Lcs-SystemManagement-Domain'
}

{ #category : #'instance  creation' }
LcsDomainObjectChangeRecords class >> new [ 
	self traceCr: ' new ' , self name.
	^ super new
]
