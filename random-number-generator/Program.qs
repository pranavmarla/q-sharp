namespace RandomNumberGenerator
{
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    
    operation SampleQuantumRandomNumberGenerator(): Result 
    {
        using (q = Qubit()) // Allocate a qubit -- always starts off in the Zero state.
        {
            H(q); // Put the qubit to superposition. It now has a 50% chance of being 0 or 1.
            return MResetZ(q); // Measure the qubit value.
        }
    }

    operation SampleRandomNumberInRange(max: Int): Int 
    {
        mutable bits = new Result[0];
        for (idxBit in 1..BitSizeI(max)) 
        {
            set bits += [SampleQuantumRandomNumberGenerator()];
        }
        let sample = ResultArrayAsInt(bits);

        if (sample > max)
        {
            return SampleRandomNumberInRange(max);
        }
        else
        {
            return sample;
        }

        // return sample > max
        //     ? SampleRandomNumberInRange(max)
        //     | sample;
    }

    @EntryPoint()
    operation SampleRandomNumber(): Int 
    {
        let max = 50;
        Message($"Sampling a random number between 0 and {max}: ");
        return SampleRandomNumberInRange(max);
    }
}
