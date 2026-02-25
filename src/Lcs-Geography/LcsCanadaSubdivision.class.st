Class {
	#name : 'LcsCanadaSubdivision',
	#superclass : 'LcsBaseCountrySubdivision',
	#category : 'Lcs-Geography-Core',
	#package : 'Lcs-Geography',
	#tag : 'Core'
}

{ #category : 'printing' }
LcsCanadaSubdivision >> gtDisplayOn: stream [
	self gtPrint: self isoCode on: stream
]
