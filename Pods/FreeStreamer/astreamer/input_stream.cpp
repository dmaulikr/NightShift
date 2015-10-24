/*
 * This file is part of the FreeStreamer project,
 * (C)Copyright 2011-2015 Matias Muhonen <mmu@iki.fi>
 * See the file ''LICENSE'' for using the code.
 *
 * https://github.com/muhku/FreeStreamer
 */

#include "input_stream.h"

namespace astreamer {
    
Input_Stream::Input_Stream() : m_delegate(0)
{
}
    
Input_Stream::~Input_Stream()
{
}
    
}